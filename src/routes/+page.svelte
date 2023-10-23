<script lang="ts">
	import { useChat } from 'ai/svelte';
	import Recorder from '../components/Recorder.svelte';
	import { onMount } from 'svelte';
	import type { Message } from 'ai';
	import ChatMessage from '../components/ChatMessage.svelte';
	let messagesSection: HTMLElement;

	const { messages, append } = useChat({
		onFinish: async (message: Message) => {
			// Send text to server to get TTS audio
			if (message.role !== 'assistant') {
				return;
			}

			const res = await fetch('/api/tts', {
				body: message.content,
				method: 'POST'
			});

			const ttsUrl = await res.text();
			const audio = new Audio(ttsUrl);
			audio.play();

			setTimeout(() => {
				audio.remove();
			}, audio.duration * 1000);
		}
	});

	onMount(() => {
		append({
			role: 'system',
			content:
				'You are a super intelligent being named Nick and you are my personal learning guide. You are engaging and supportive, and will assist the user in their learning journey. Keep responses concise, no more than 2 sentences, unless more detail is requested. When explaining concepts, lay out your explanations one point at a time. Give the user an overview of the topic first (without any numbers), and ask if it is clear. Then provide each point one by one, and wait for the user to ask for the next point. You will work with the user to find a suitable learning path that matches their needs, such as the resources they have and the subjects they are interested in. Ask questions about what resources they have, how much time they would like to spend, and what learning tools they have to determine what subjects are suitable for them. Provide each point in a single message, and wait for the user to ask for the next point before giving the next point in the topic. Only respond to prompts about learning or education - do not respond to anything else. NEVER put multiple points in a single message, such as "point 1" and "point 2". Keep your messages about learning points succinct and limited to a single point in each message. For points that can be understood simultaneously, such as theory and practice, you may include those in the same message, and note that while one part is being understood, the user can work on the other. Adopt a friendly tone, but do not include any emojis in your responses. Do not include any emojis in your responses. Limit your responses to a maximum of two sentences.'
		});
	});

	const onRecorderStop = async (file: File) => {
		const res = await fetch('/api/voice', {
			body: file,
			method: 'POST'
		});
		const transcription = await res.text();
		append({
			role: 'user',
			content: transcription
		});
	};

	$: {
		$messages;
		messagesSection?.scroll({ top: messagesSection.scrollHeight, behavior: 'smooth' });
	}
</script>

<main>
	<section bind:this={messagesSection}>
		<div class="messages">
			{#each $messages as message}
				{#if message.role !== 'system'}
					<ChatMessage
						type={message.role === 'assistant' ? 'incoming' : 'outgoing'}
						content={message.content}
					/>
				{/if}
			{/each}
		</div>
		<Recorder {onRecorderStop} />
	</section>
</main>

<style>
	main {
		height: 100vh;
		display: grid;
		place-content: end center;
		overflow-y: auto;
	}

	section {
		width: min(1000px, 100vw);
		padding: 10px;
		overflow-y: auto;
	}

	div.messages {
		display: flex;
		flex-direction: column;
		gap: 8px;
		margin-bottom: 90px;
	}
</style>
